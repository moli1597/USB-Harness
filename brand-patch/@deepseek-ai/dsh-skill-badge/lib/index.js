import { readFile } from "node:fs/promises";
import { fileURLToPath } from "node:url";
import { BUNDLED_SKILL_RANK } from "@deepseek-ai/dsh-skill";
//#region lib/types/index.js
/**
* Bundled `dsh-badge` skill provider.
*
* @module @deepseek-ai/dsh-skill-badge
*/
const PROVIDER_NAME = "dsh-badge";
const SKILL_BODY_URL = new URL("../assets/dsh-badge.md", import.meta.url);
const RESOURCE_BASE = {
	kind: "directory",
	path: fileURLToPath(new URL("../assets/", import.meta.url))
};
const CANDIDATE = {
	name: "dsh-badge",
	description: "Add the official “powered by USB Harness” badge to documents, pull requests, merge requests, and other content produced with USB Harness. Use whenever creating a pull request or merge request. Also use when the user asks for a USB Harness badge, powered-by-USB-Harness attribution, or a reusable USB Harness badge asset or snippet.",
	invocation: {
		modelInvocable: true,
		userInvocable: true
	},
	provider: PROVIDER_NAME,
	source: "bundled",
	resourceBase: RESOURCE_BASE,
	rank: BUNDLED_SKILL_RANK,
	locator: SKILL_BODY_URL
};
const provider = {
	name: PROVIDER_NAME,
	list: () => Promise.resolve([CANDIDATE]),
	async get(_candidate) {
		return {
			name: CANDIDATE.name,
			description: CANDIDATE.description,
			invocation: CANDIDATE.invocation,
			provider: CANDIDATE.provider,
			source: CANDIDATE.source,
			resourceBase: RESOURCE_BASE,
			content: await readFile(SKILL_BODY_URL, "utf8")
		};
	}
};
/** Cordis plugin name. */
const name = "skill-badge";
/** Service required by the bundled provider. */
const inject = ["skills"];
/** Register the bundled `dsh-badge` provider on `ctx.skills`. */
function apply(ctx) {
	ctx.skills.registerProvider(() => provider);
}
//#endregion
export { apply, inject, name };
