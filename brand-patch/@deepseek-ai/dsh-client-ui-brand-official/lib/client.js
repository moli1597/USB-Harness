window.__ModuleLoader__.load({
	id: "@deepseek-ai/dsh-client-ui-brand-official",
	factory: (require) => {
		var module = { exports: {} };
		var exports = module.exports;
		Object.defineProperty(exports, Symbol.toStringTag, { value: "Module" });
		let react_jsx_runtime = require("react/jsx-runtime");
		//#region lib/types/client/Brand.js
		function OfficialBrandMark({ size = 24, className }) {
			return (0, react_jsx_runtime.jsx)("svg", {
				width: size,
				height: size,
				viewBox: "0 0 24 24",
				fill: "none",
				className,
				"aria-label": "USB Harness",
				children: [
					(0, react_jsx_runtime.jsx)("circle", { cx: 12, cy: 5, r: 2.3, fill: "none", stroke: "currentColor", strokeWidth: 2, strokeLinecap: "round" }),
					(0, react_jsx_runtime.jsx)("line", { x1: 12, y1: 7.3, x2: 12, y2: 9.5, stroke: "currentColor", strokeWidth: 2, strokeLinecap: "round" }),
					(0, react_jsx_runtime.jsx)("rect", { x: 8.6, y: 9.5, width: 6.8, height: 3.1, rx: 1.1, fill: "currentColor", stroke: "none" }),
					(0, react_jsx_runtime.jsx)("path", { d: "M10 12.6 L10 15.2 L12 18.6 L14 15.2 L14 12.6", fill: "none", stroke: "currentColor", strokeWidth: 2, strokeLinecap: "round", strokeLinejoin: "round" })
				]
			});
		}
		function OfficialBrandName() {
			return (0, react_jsx_runtime.jsx)("span", {
				children: "USB Harness",
				style: { fontWeight: 600, letterSpacing: "0.02em" }
			});
		}
		//#endregion
		//#region lib/types/client/index.js
		const inject = ["slots"];
		function apply(ctx) {
			ctx.slots.inject("sidebar.brand.mark", () => ctx.slots.inject("sidebar.brand.name", () => ctx.slots.inject("conversation.hero.brand.mark", function* () {
				yield ctx.slots.register({ name: "sidebar.brand.mark" }, OfficialBrandMark);
				yield ctx.slots.register({ name: "sidebar.brand.name" }, OfficialBrandName);
				yield ctx.slots.register({ name: "conversation.hero.brand.mark" }, OfficialBrandMark);
			})));
		}
		//#endregion
		exports.apply = apply;
		exports.inject = inject;
		return module.exports;
	}
});
