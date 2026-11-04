/**
 * Prints the resume as Markdown from config.toml, with the same sections in
 * the same order as the web page: header, bio, Experience, Technical Skills,
 * and Interests.
 *
 * Usage: bun scripts/resume-md.ts > public/resume.md
 */

interface Job {
  title: string;
  company: string;
  start_date: string;
  end_date: string;
  summary?: string;
  achievements?: string[];
  technologies?: string[];
}

interface Skill {
  name: string;
  keywords: string[];
}

interface Interest {
  title: string;
  description: string;
  technologies?: string[];
}

interface Extra {
  name: string;
  job_title: string;
  bio: string;
  email: string;
  phone: string;
  location: string;
  website: string;
  github?: string;
  experience: Job[];
  skills: Skill[];
  projects: Interest[];
}

const source = await Bun.file(new URL("../config.toml", import.meta.url)).text();
const { extra } = Bun.TOML.parse(source) as { extra: Extra };

const bare = (url: string) => url.replace(/^https?:\/\//, "");
const link = (url: string) => `[${bare(url)}](${url})`;

const contact = [
  `[${extra.email}](mailto:${extra.email})`,
  extra.phone,
  extra.location,
  ...(extra.github ? [link(extra.github)] : []),
  link(extra.website),
];

const lines = [
  `# ${extra.name}`,
  "",
  extra.job_title,
  "",
  contact.join(" · "),
  "",
  extra.bio.trim(),
  "",
  "## Experience",
];

for (const job of extra.experience) {
  lines.push("", `### ${job.title}, ${job.company}`, "", `${job.start_date} – ${job.end_date}`);
  if (job.summary) lines.push("", job.summary);
  if (job.achievements?.length) lines.push("", ...job.achievements.map((a) => `- ${a}`));
  if (job.technologies?.length) lines.push("", `Technologies: ${job.technologies.join(", ")}`);
}

lines.push("", "## Technical Skills", "");
for (const skill of extra.skills) lines.push(`- **${skill.name}:** ${skill.keywords.join(", ")}`);

lines.push("", "## Interests", "");
for (const interest of extra.projects) {
  const tags = interest.technologies?.length ? ` (${interest.technologies.join(", ")})` : "";
  lines.push(`- **${interest.title}:** ${interest.description}${tags}`);
}

console.log(lines.join("\n"));
