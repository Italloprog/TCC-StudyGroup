import { Request, Response } from "express";

export class userController{

    constructor(){
    }
    
    public pesquisarUsuario = async (_req: Request, res: Response) =>{
        res.send('Hello, World!trueform');
    }

    public editarUsuario = async (_req: Request, res: Response) =>{
        res.send('Hello, World!trueform');
    }
}