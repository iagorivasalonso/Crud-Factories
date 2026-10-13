
class ApiConfigUrl {

    static bool useLocalhost = false;

    static  String  get baseUrl => useLocalhost
        ? 'http://localhost:3000'
        : 'https://crud-factories.onrender.com';
}