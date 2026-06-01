"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.commentRoutes = void 0;
const commentController_1 = require("../controllers/commentController");
const commonRoutes_1 = require("./commonRoutes");
class commentRoutes extends commonRoutes_1.CommonRoutes {
    constructor(app) {
        super('Rotas de Comentários', app, '/comentarios');
    }
    configureRoutes() {
        const controller = new commentController_1.commentController();
        this.app.route(this.rota)
            .post((req, res) => controller.adicionarComentario(req, res));
        this.app.route(`${this.rota}/:id_Comentario`)
            .delete((req, res) => controller.removerComentario(req, res));
        return this.app;
    }
}
exports.commentRoutes = commentRoutes;
//# sourceMappingURL=commentRoutes.js.map