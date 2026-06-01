"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.groupRoutes = void 0;
const commonRoutes_1 = require("./commonRoutes");
const groupController_1 = require("../controllers/groupController");
class groupRoutes extends commonRoutes_1.CommonRoutes {
    constructor(app) {
        super('Rotas de Grupos de Estudo', app, '/grupos');
    }
    configureRoutes() {
        const controller = new groupController_1.groupController();
        this.app.route(this.rota)
            .post((req, res) => controller.criarGrupo(req, res));
        this.app.route(`${this.rota}/:id_Grupo`)
            .put((req, res) => controller.editarGrupo(req, res));
        this.app.route(`${this.rota}/:id_Grupo/encerrar`)
            .delete((req, res) => controller.encerrarGrupo(req, res));
        this.app.route(`${this.rota}/entrar`)
            .post((req, res) => controller.entrarGrupo(req, res));
        this.app.route(`${this.rota}/:id_Grupo/sair`)
            .post((req, res) => controller.deixarGrupo(req, res));
        this.app.route(`${this.rota}/:id_Grupo/usuarios/:id_Usuario_Removido`)
            .delete((req, res) => controller.removerUsuario(req, res));
        this.app.route(`${this.rota}/:id_Grupo/ranking`)
            .get((req, res) => controller.gerarRanking(req, res));
        return this.app;
    }
}
exports.groupRoutes = groupRoutes;
//# sourceMappingURL=groupRoutes.js.map