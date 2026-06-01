"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Usuario = void 0;
class Usuario {
    constructor(id_Usuario, nome, foto_Perfil, senha, email, biografia) {
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
exports.Usuario = Usuario;
//# sourceMappingURL=userEntity.js.map