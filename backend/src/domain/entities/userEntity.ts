import { Grupo_de_Estudo } from "./groupEntity";
import { Postagem } from "./postEntity";

export class Usuario {
    public id_Usuario: string;
    public nome: string;
    public foto_Perfil: string;
    private senha: string;
    public email: string;
    public biografia: string;
    public total_Pontos: number;
    public ofensiva_Atual: number;
    public maior_Ofensiva: number;
    public grupos_Ativos: Grupo_de_Estudo[];
    public postagens: Postagem[];
    
    private qtd_Posts_Exatas: number;
    private qtd_Posts_Humanas: number;
    private qtd_Posts_Saude: number;
    private qtd_Posts_Socias: number;
    private qtd_Posts_Linguagens: number;

    constructor(id_Usuario: string, nome: string, foto_Perfil: string, senha: string, email: string, biografia: string) {
        this.id_Usuario = id_Usuario;
        this.nome = nome;
        this.foto_Perfil = foto_Perfil;
        this.senha = senha;
        this.email = email;
        this.biografia = biografia;
        
        this.total_Pontos = 0;
        this.ofensiva_Atual = 0;
        this.maior_Ofensiva = 0;
        this.qtd_Posts_Exatas = 0;
        this.qtd_Posts_Humanas = 0;
        this.qtd_Posts_Saude = 0;
        this.qtd_Posts_Socias = 0;
        this.qtd_Posts_Linguagens = 0;
        this.grupos_Ativos = [];
        this.postagens = [];
    }
}