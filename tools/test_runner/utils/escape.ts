type esc = "&" | "<" | ">" | "'" | '"';

const escapeChars = {
  "&": "&amp;",
  "<": "&lt;",
  ">": "&gt;",
  "'": "&#39;",
  '"': "&quot;",
};

const pe = (m: string) => {
  return escapeChars[m as esc];
};

export function escape(es: string): string {
  return es.replaceAll(/["&'<>]/g, pe);
}
