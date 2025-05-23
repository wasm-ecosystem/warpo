import esbuild from "esbuild";

let ctx = await esbuild.context({
  entryPoints: ["tools/asc/asc.ts"],
  bundle: true,
  outfile: "bin/asc.js",
  platform: "node",
  minify: false,
  format: "esm",
});

if (process.argv.includes("--watch")) {
  await ctx.watch();
  console.log("watching...");
} else {
  await ctx.rebuild();
  ctx.dispose();
}
