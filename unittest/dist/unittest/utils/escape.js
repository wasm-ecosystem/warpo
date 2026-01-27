const esca = {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    "'": "&#39;",
    '"': "&quot;",
};
const pe = (m) => {
    return esca[m];
};
export function escape(es) {
    return es.replaceAll(/["&'<>]/g, pe);
}
//# sourceMappingURL=escape.js.map