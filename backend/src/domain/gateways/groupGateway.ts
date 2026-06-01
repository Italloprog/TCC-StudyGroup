import { Grupo_de_Estudo } from "../entities/groupEntity";
import { Usuario } from "../entities/userEntity";

export interface GrupoDeEstudoGateway {
    // Ações de criação e edição
    criarGrupo(id_Dono: string, imagem: string, nome: string, descricao: string, modo_pontuacao: number, qtd_dias: number): Promise<Grupo_de_Estudo>;
    editarGrupo(id_Grupo: string, id_Dono: string, imagem: string, nome: string, descricao: string, modo_pontuacao: number, qtd_dias: number): Promise<boolean>;
    encerrarGrupo(id_Grupo: string, id_Dono: string): Promise<boolean>;

    // Gestão de participantes
    entrarGrupo(id_Usuario: string, codigo_convite: string): Promise<boolean>;
    deixarGrupo(id_Usuario: string, id_Grupo: string): Promise<boolean>;
    removerUsuario(id_Grupo: string, id_Dono: string, id_Usuario_Removido: string): Promise<boolean>; // Exclusivo para dono do grupo

    // Queries e Regras de Negócio dependentes do BD
    gerarRanking(id_Grupo: string): Promise<Usuario[]>;
}