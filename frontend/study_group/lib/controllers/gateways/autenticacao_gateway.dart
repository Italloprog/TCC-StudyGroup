abstract class AutenticacaoGateway {
  Future<void> login(String email, String password);
  Future<void> register(String nome, String email, String password);
  Future<void> logout();
  Future<void> deleteAccount();
}