#!/usr/bin/env node
// Fails if any dependency in package.json (root + workspace packages) uses a
// range specifier. Exact versions only — `workspace:`, `catalog:`, `npm:` with
// an exact version, file/link/git pins are allowed.
import { readFileSync, existsSync, readdirSync, statSync } from "node:fs";
import { join, dirname } from "node:path";

const SECTIONS = ["dependencies", "devDependencies", "optionalDependencies", "peerDependencies"];
const EXACT = /^\d+\.\d+\.\d+(-[\w.]+)?(\+[\w.]+)?$/;

function isAllowed(spec) {
  if (typeof spec !== "string") return false;
  if (EXACT.test(spec)) return true;
  if (spec.startsWith("workspace:") || spec.startsWith("catalog:")) return true;
  if (spec.startsWith("file:") || spec.startsWith("link:") || spec.startsWith("portal:")) return true;
  if (spec.startsWith("git+") || spec.startsWith("github:")) return spec.includes("#");
  if (spec.startsWith("npm:")) {
    const at = spec.lastIndexOf("@");
    return at > 4 && EXACT.test(spec.slice(at + 1));
  }
  return false;
}

function* packageJsonFiles(root) {
  const rootPkg = join(root, "package.json");
  if (existsSync(rootPkg)) yield rootPkg;
  // workspace globs: check conventional dirs (apps/*, packages/*) plus declared workspaces
  const declared = (() => {
    try {
      const p = JSON.parse(readFileSync(rootPkg, "utf8"));
      const w = Array.isArray(p.workspaces) ? p.workspaces : p.workspaces?.packages;
      return Array.isArray(w) ? w : [];
    } catch {
      return [];
    }
  })();
  const dirs = new Set(
    ["apps", "packages", ...declared.map((g) => g.split("/")[0])].filter(
      (d) => d && !d.includes("*") && existsSync(join(root, d)),
    ),
  );
  for (const d of dirs) {
    for (const sub of readdirSync(join(root, d))) {
      const pkg = join(root, d, sub, "package.json");
      if (existsSync(pkg) && statSync(pkg).isFile()) yield pkg;
    }
  }
}

let bad = 0;
for (const file of packageJsonFiles(process.cwd())) {
  const pkg = JSON.parse(readFileSync(file, "utf8"));
  for (const section of SECTIONS) {
    for (const [name, spec] of Object.entries(pkg[section] ?? {})) {
      // peerDependencies legitimately use ranges for libraries
      if (section === "peerDependencies") continue;
      if (!isAllowed(spec)) {
        console.error(`UNPINNED  ${file}  ${section}.${name} = "${spec}"`);
        bad++;
      }
    }
  }
}

if (bad > 0) {
  console.error(`\n${bad} unpinned dependency specifier(s). Use exact versions (save-exact).`);
  process.exit(1);
}
console.log("All dependency specifiers exact-pinned.");
