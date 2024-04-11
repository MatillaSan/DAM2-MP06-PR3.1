package cat.iesesteveterradas;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.basex.api.client.ClientSession;
import org.basex.core.*;
import org.basex.core.cmd.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Main {
    private static final Logger logger = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) throws IOException {
        // Initialize connection details
        String host = "127.0.0.1";
        int port = 1984;
        String username = "admin"; // Default username
        String password = "admin"; // Default password

        // Establish a connection to the BaseX server
        try (ClientSession session = new ClientSession(host, port, username, password)) {
            logger.info("Connected to BaseX server.");

            // Directorios de entrada y salida
            String inputDirectory = "./data/input";
            String outputDirectory = "./data/output";

            // Obtener la lista de archivos .xquery en el directorio de entrada
            File[] queryFiles = new File(inputDirectory).listFiles((dir, name) -> name.endsWith(".xquery"));

            if (queryFiles != null) {
                for (File queryFile : queryFiles) {
                    try {
                        // Leer el contenido del archivo .xquery
                        String query = Files.readString(queryFile.toPath());

                        // Ejecutar la consulta en BaseX
                        String result = session.execute(new XQuery(query));

                        // Guardar el resultado como un archivo .xml en el directorio de salida
                        saveResult(result, outputDirectory, queryFile.getName().replace(".xquery", ".xml"));

                        System.out.println("Consulta ejecutada y resultado guardado para: " + queryFile.getName());
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                System.out.println("No se encontraron archivos .xquery en el directorio de entrada.");
            }

        } catch (BaseXException e) {
            logger.error("Error connecting or executing the query: " + e.getMessage());
        } catch (IOException e) {
            logger.error(e.getMessage());
        }
    }

    // Método para guardar el resultado como un archivo .xml
    private static void saveResult(String result, String outputDirectory, String fileName) {
        try {
            Path outputPath = Paths.get(outputDirectory, fileName);
            FileWriter writer = new FileWriter(outputPath.toFile());
            writer.write(result);
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
