import { Application } from 'express';
import { userController } from '../controllers/userController';
import { CommonRoutes } from './commonRoutes';

export class userRoutes extends CommonRoutes {

    constructor(app: Application) {
        super('Rotas de Usuários', app, '/usuarios');
    }

    configureRoutes(): Application {
        const controller: userController = new userController();
        
        // GET /usuarios/pesquisar?nome=...
        this.app.route(`${this.rota}/pesquisar`)
            .get((req, res) => controller.pesquisarUsuario(req, res));

        // PUT /usuarios/:id_Usuario (Editar perfil)
        this.app.route(`${this.rota}/:id_Usuario`)
            .put((req, res) => controller.editarUsuario(req, res));
        
        return this.app;
    }
}