"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.postRoutes = void 0;
const commonRoutes_1 = require("./commonRoutes");
const postController_1 = require("../controllers/postController");
class postRoutes extends commonRoutes_1.CommonRoutes {
    constructor(app) {
        super('Rotas de Postagens', app, '/postagens');
    }
    configureRoutes() {
        const controller = new postController_1.postController();
        this.app.route(this.rota)
            .post((req, res) => controller.criarPostagem(req, res));
        this.app.route(`${this.rota}/:id_Postagem`)
            .delete((req, res) => controller.removerPostagem(req, res));
        return this.app;
    }
}
exports.postRoutes = postRoutes;
//# sourceMappingURL=postRoutes.js.map