import $ from "jquery";

const authenticityToken = $("meta[name=csrf-token]").attr("content");

export default authenticityToken;
