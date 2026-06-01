"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Grupo_de_Estudo = void 0;
class Grupo_de_Estudo {
    constructor(id_Grupo, imagem, nome, descricao, modo_Pontuacao, data_Inicio, duração, dono, codigo_convite) {
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
exports.Grupo_de_Estudo = Grupo_de_Estudo;
//# sourceMappingURL=groupEntity.js.map