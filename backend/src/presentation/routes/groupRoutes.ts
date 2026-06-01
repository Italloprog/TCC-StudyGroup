import { Application } from 'express';
import { CommonRoutes } from './commonRoutes';
import { groupController } from '../controllers/groupController';

export class groupRoutes extends CommonRoutes {

    constructor(app: Application) {
        super('Rotas de Grupos de Estudo', app, '/grupos');
    }

    configureRoutes(): Application {
        const controller: groupController = new groupController();
        
        // POST /grupos (Criar novo grupo)
        this.app.route(this.rota)
            .post((req, res) => controller.criarGrupo(req, res));

        // PUT /grupos/:id_Grupo (Editar grupo)
        this.app.route(`${this.rota}/:id_Grupo`)
            .put((req, res) => controller.editarGrupo(req, res));

        // DELETE /grupos/:id_Grupo/encerrar
        this.app.route(`${this.rota}/:id_Grupo/encerrar`)
            .delete((req, res) => controller.encerrarGrupo(req, res));

        // POST /grupos/entrar (Entrar usando código de convite)
        this.app.route(`${this.rota}/entrar`)
            .post((req, res) => controller.entrarGrupo(req, res));

        // POST /grupos/:id_Grupo/sair (Usuário deixa o grupo voluntariamente)
        this.app.route(`${this.rota}/:id_Grupo/sair`)
            .post((req, res) => controller.deixarGrupo(req, res));

        // DELETE /grupos/:id_Grupo/usuarios/:id_Usuario_Removido (Dono remove participante)
        this.app.route(`${this.rota}/:id_Grupo/usuarios/:id_Usuario_Removido`)
            .delete((req, res) => controller.removerUsuario(req, res));

        // GET /grupos/:id_Grupo/ranking (Gerar ranking de pontuação)
        this.app.route(`${this.rota}/:id_Grupo/ranking`)
            .get((req, res) => controller.gerarRanking(req, res));

        return this.app;
    }
}