"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const userRoutes_1 = require("./presentation/routes/userRoutes");
const commentRoutes_1 = require("./presentation/routes/commentRoutes");
const groupRoutes_1 = require("./presentation/routes/groupRoutes");
const postRoutes_1 = require("./presentation/routes/postRoutes");
const port = 3000;
const app = (0, express_1.default)();
app.use(express_1.default.json());
app.get('/', (_req, res) => {
    res.send('Hello, World!baby');
});
new userRoutes_1.userRoutes(app);
new postRoutes_1.postRoutes(app);
new groupRoutes_1.groupRoutes(app);
new commentRoutes_1.commentRoutes(app);
app.listen(port, '0.0.0.0', () => {
    console.log(`Servidor rodando na porta ${port}`);
});
//# sourceMappingURL=server.js.map