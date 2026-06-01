"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Dono_de_Grupo = void 0;
const userEntity_1 = require("./userEntity");
class Dono_de_Grupo extends userEntity_1.Usuario {
    constructor(id_Usuario, nome, foto_Perfil, senha, email, biografia, grupos_Possuidos = []) {
        super(id_Usuario, nome, foto_Perfil, senha, email, biografia);
        this.grupos_Possuidos = grupos_Possuidos;
    }
}
exports.Dono_de_Grupo = Dono_de_Grupo;
//# sourceMappingURL=ownerUserEntity.js.map