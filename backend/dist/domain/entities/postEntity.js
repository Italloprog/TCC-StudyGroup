"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Postagem = void 0;
class Postagem {
    constructor(id_Postagem, titulo, imagem, tempo, dono_Postagem, data, area_Estudo, descricao) {
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
exports.Postagem = Postagem;
//# sourceMappingURL=postEntity.js.map