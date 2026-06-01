import { Grupo_de_Estudo } from "./groupEntity";
import { Usuario } from "./userEntity";

export class Dono_de_Grupo extends Usuario {
    // Alterado de um único objeto para uma lista (array) de grupos
    public grupos_Possuidos: Grupo_de_Estudo[];

    constructor(
        id_Usuario: string, 
        nome: string, 
        foto_Perfil: string, 
        senha: string, 
        email: string, 
        biografia: string, 
        grupos_Possuidos: Grupo_de_Estudo[] = [] // Inicializa vazio caso seja um novo dono
    ) {
        super(id_Usuario, nome, foto_Perfil, senha, email, biografia);
        this.grupos_Possuidos = grupos_Possuidos;
    }
}