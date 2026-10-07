import com.sun.net.httpserver.HttpServer;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
public class Hello {
 public static void main(String[] args) throws Exception {
  var server = HttpServer.create(new InetSocketAddress(8080), 0);
  server.createContext("/", exchange -> {
   byte[] body = "<h1>Hello World from Java</h1>".getBytes(StandardCharsets.UTF_8);
   exchange.getResponseHeaders().set("Content-Type", "text/html");
   exchange.sendResponseHeaders(200, body.length);
   try(var out = exchange.getResponseBody()) { out.write(body); }
  });
  server.start();
 }
}
