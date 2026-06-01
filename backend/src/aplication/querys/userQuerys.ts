import { UsuarioGateway } from "../../domain/gateways/userGateway";
import { UserRepository } from "../../persistence/firebase/repositories/userRepository";

export class userQuerys{
    private userRepo: UsuarioGateway = new UserRepository();

    
}