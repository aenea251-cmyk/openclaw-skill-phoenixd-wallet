#!/usr/bin/env node
/*
  Local QR generation for BOLT11 invoices.

  - No network calls.
  - Outputs either SVG (default) or ASCII to stdout.

  Depends on vendored qrcodegen (MIT):
    scripts/vendor/qrcodegen-v1.8.0-es6.js
*/

import fs from "node:fs";
import path from "node:path";
import vm from "node:vm";

function usage() {
  console.error(`Usage:
  bolt11_qr.mjs "<bolt11>" [--svg out.svg] [--border 4] [--scale 8]
  bolt11_qr.mjs "<bolt11>" --ascii [--border 2]

Examples:
  ./scripts/bolt11_qr.mjs "$INVOICE" --svg invoice.svg --scale 8
  ./scripts/bolt11_qr.mjs "$INVOICE" --ascii
`);
  process.exit(2);
}

const args = process.argv.slice(2);
if (args.length === 0) usage();

const invoice = args[0];
let outSvg = null;
let ascii = false;
let border = 4;
let scale = 8;

for (let i = 1; i < args.length; i++) {
  const a = args[i];
  if (a === "--svg") outSvg = args[++i] ?? null;
  else if (a === "--ascii") ascii = true;
  else if (a === "--border") border = parseInt(args[++i] ?? "", 10);
  else if (a === "--scale") scale = parseInt(args[++i] ?? "", 10);
  else usage();
}

if (!invoice || typeof invoice !== "string") usage();

const vendorPath = path.resolve(path.dirname(new URL(import.meta.url).pathname), "vendor", "qrcodegen-v1.8.0-es6.js");
const code = fs.readFileSync(vendorPath, "utf8");
const context = { console };
vm.runInNewContext(code, context, { filename: vendorPath });
const qrcodegen = context.qrcodegen;
if (!qrcodegen?.QrCode) throw new Error("Failed to load vendored qrcodegen");

const QRC = qrcodegen.QrCode;
const qr = QRC.encodeText(invoice, QRC.Ecc.MEDIUM);

function toSvgString(qr, border, scale) {
  if (border < 0 || scale <= 0) throw new Error("Invalid border/scale");
  const size = qr.size;
  const full = size + border * 2;
  const dim = full * scale;
  let parts = [];
  parts.push(`<?xml version="1.0" encoding="UTF-8"?>`);
  parts.push(`<svg xmlns="http://www.w3.org/2000/svg" width="${dim}" height="${dim}" viewBox="0 0 ${full} ${full}" shape-rendering="crispEdges">`);
  parts.push(`<rect width="100%" height="100%" fill="#fff"/>`);
  parts.push(`<g fill="#000">`);
  for (let y = 0; y < size; y++) {
    for (let x = 0; x < size; x++) {
      if (qr.getModule(x, y)) {
        parts.push(`<rect x="${x + border}" y="${y + border}" width="1" height="1"/>`);
      }
    }
  }
  parts.push(`</g></svg>`);
  return parts.join("\n");
}

function toAscii(qr, border) {
  // Render using Unicode full blocks; pack 2 rows per terminal row.
  const size = qr.size;
  const full = size + border * 2;
  const get = (x, y) => {
    const xx = x - border;
    const yy = y - border;
    return (xx >= 0 && yy >= 0 && xx < size && yy < size) ? qr.getModule(xx, yy) : false;
  };

  let lines = [];
  for (let y = 0; y < full; y += 2) {
    let line = "";
    for (let x = 0; x < full; x++) {
      const top = get(x, y);
      const bot = get(x, y + 1);
      line += top && bot ? "█" : top && !bot ? "▀" : !top && bot ? "▄" : " ";
    }
    lines.push(line);
  }
  return lines.join("\n");
}

if (ascii) {
  process.stdout.write(toAscii(qr, border) + "\n");
} else {
  const svg = toSvgString(qr, border, scale);
  if (outSvg) {
    fs.writeFileSync(outSvg, svg);
    console.error(`Wrote ${outSvg}`);
  } else {
    process.stdout.write(svg + "\n");
  }
}
