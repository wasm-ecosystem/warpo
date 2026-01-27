type esc = "&" | "<" | ">" | "'" | '"';

const esca = {
  "&": "&amp;",
  "<": "&lt;",
  ">": "&gt;",
  "'": "&#39;",
  '"': "&quot;",
};

const pe = (m: string) => {
  return esca[m as esc];
};

export function escape(es: string): string {
  return es.replaceAll(/["&'<>]/g, pe);
}
