import { Postagem } from "../entities/postEntity";

export interface PostagemGateway {
    // Criar uma postagem vinculada a um grupo e a um usuário
    criarPostagem(id_Grupo: string, titulo: string, imagem: string, descricao: string, tempo: number, area: string, id_Dono: string): Promise<Postagem>;
    
    // Remover uma postagem garantindo que quem remove é o dono
    removerPostagem(id_Postagem: string, id_Usuario: string): Promise<boolean>;
}