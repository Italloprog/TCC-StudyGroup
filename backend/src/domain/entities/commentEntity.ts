import { Usuario } from "./userEntity";

export class Comentario {
    public id_Comentario: number;
    public dono_Comentario: Usuario;
    public conteudo: string;

    constructor(id_Comentario: number, dono_Comentario: Usuario, conteudo: string) {
        this.id_Comentario = id_Comentario;
        this.dono_Comentario = dono_Comentario;
        this.conteudo = conteudo;
    }
}