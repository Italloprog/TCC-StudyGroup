import { Application } from 'express';
import { commentController } from '../controllers/commentController';
import { CommonRoutes } from './commonRoutes';

export class commentRoutes extends CommonRoutes {

    constructor(app: Application) {
        super('Rotas de Comentários', app, '/comentarios');
    }

    configureRoutes(): Application {
        const controller: commentController = new commentController();
        
        // POST /comentarios (Adicionar um comentário a uma postagem)
        this.app.route(this.rota)
            .post((req, res) => controller.adicionarComentario(req, res));

        // DELETE /comentarios/:id_Comentario (Remover comentário)
        this.app.route(`${this.rota}/:id_Comentario`)
            .delete((req, res) => controller.removerComentario(req, res));

        return this.app;
    }
}