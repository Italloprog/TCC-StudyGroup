import express from 'express';
import { userRoutes } from './presentation/routes/userRoutes';
import { commentRoutes } from './presentation/routes/commentRoutes';
import { groupRoutes } from './presentation/routes/groupRoutes';
import { postRoutes } from './presentation/routes/postRoutes';

const port = 3000;

const app = express();

app.use(express.json());

app.get('/', (_req, res) => {
    res.send('Hello, World!baby');
});

new userRoutes(app);
new postRoutes(app);
new groupRoutes(app);
new commentRoutes(app);

app.listen(port, '0.0.0.0', () => {
    console.log(`Servidor rodando na porta ${port}`);
});