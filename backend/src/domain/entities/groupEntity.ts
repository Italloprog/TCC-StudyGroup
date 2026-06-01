import { Dono_de_Grupo } from "./ownerUserEntity";
import { Postagem } from "./postEntity";
import { Usuario } from "./userEntity";

export class Grupo_de_Estudo {
    public id_Grupo: string;
    public imagem: string;
    public nome: string;
    public descricao: string;
    public modo_Pontuacao: number;
    public data_Inicio: Date;
    public duração: number;
    public participantes: Usuario[];
    public dono: Dono_de_Grupo;
    public postagens: Postagem[];
    public codigo_convite: string;

    constructor(id_Grupo: string, imagem: string, nome: string, descricao: string, modo_Pontuacao: number, data_Inicio: Date, duração: number, dono: Dono_de_Grupo, codigo_convite: string) {
        this.id_Grupo = id_Grupo;
        this.imagem = imagem;
        this.nome = nome;
        this.descricao = descricao;
        this.modo_Pontuacao = modo_Pontuacao;
        this.data_Inicio = data_Inicio;
        this.duração = duração;
        this.dono = dono;
        this.codigo_convite = codigo_convite;
        
        this.participantes = []; 
        this.postagens = [];
    }
}