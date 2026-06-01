import { Usuario } from "../../../domain/entities/userEntity";
import { UsuarioGateway } from "../../../domain/gateways/userGateway";

export class UserRepository implements UsuarioGateway {

    pesquisarUsuario(nome: string): Promise<Usuario[]> {
        throw new Error("Method not implemented.");
    }
    
    editarUsuario(id_Usuario: string, foto: string, senha: string, confirma_Senha: string, biografia: string): Promise<boolean> {
        throw new Error("Method not implemented.");
    }

}