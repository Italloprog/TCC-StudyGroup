import { Comentario } from "./commentEntity";
import { Usuario } from "./userEntity";

export class Postagem {
    public id_Postagem: string;
    public titulo: string;
    public imagem: string;
    public tempo: number;
    public dono_Postagem: Usuario;
    public data: Date;
    public area_Estudo: string;
    public qtd_Pontos: number;
    public comentarios: Comentario[];
    public descricao: string;

    constructor(id_Postagem: string, titulo: string, imagem: string, tempo: number, dono_Postagem: Usuario, data: Date, area_Estudo: string, descricao: string) {
        this.id_Postagem = id_Postagem;
        this.titulo = titulo;
        this.imagem = imagem;
        this.tempo = tempo;
        this.dono_Postagem = dono_Postagem;
        this.data = data;
        this.area_Estudo = area_Estudo;
        this.descricao = descricao;
        
        this.qtd_Pontos = 0;
        this.comentarios = [];
    }
}