import { Usuario } from "../entities/userEntity";

export interface UsuarioGateway {
    // Retorna uma lista de usuários baseada na pesquisa de nome
    pesquisarUsuario(nome: string): Promise<Usuario[]>;
    
    // Atualiza os dados do usuário. Recebe os dados novos e retorna se teve sucesso.
    editarUsuario(id_Usuario: string, foto: string, senha: string, confirma_Senha: string, biografia: string): Promise<boolean>;
}