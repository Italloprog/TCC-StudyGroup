import { Application } from 'express';
import { CommonRoutes } from './commonRoutes';
import { postController } from '../controllers/postController';

export class postRoutes extends CommonRoutes {

    constructor(app: Application) {
        super('Rotas de Postagens', app, '/postagens');
    }

    configureRoutes(): Application {
        const controller: postController = new postController();
        
        // POST /postagens (Criar nova postagem vinculada a um grupo)
        this.app.route(this.rota)
            .post((req, res) => controller.criarPostagem(req, res));

        // DELETE /postagens/:id_Postagem (Remover postagem)
        this.app.route(`${this.rota}/:id_Postagem`)
            .delete((req, res) => controller.removerPostagem(req, res));

        return this.app;
    }
}