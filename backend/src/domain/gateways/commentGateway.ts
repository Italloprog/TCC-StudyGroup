import { Comentario } from "../entities/commentEntity";

export interface ComentarioGateway {
    // Adicionar um comentário vinculando a uma postagem e um usuário
    adicionarComentario(id_Postagem: string, id_Dono: string, conteudo: string): Promise<Comentario>;
    
    // Remover comentário garantindo autoria
    removerComentario(id_Comentario: number, id_Usuario: string): Promise<boolean>;
}