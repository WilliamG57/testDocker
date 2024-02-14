# Étape de build
FROM eclipse-temurin:17-jdk AS build

# Installer Maven
RUN apt-get update && \
    apt-get install -y maven
  
  # Définir le répertoire de travail dans l'image
WORKDIR /app
  
  # Copier le fichier pom.xml et les sources dans l'image
COPY pom.xml .
COPY src src
  
  # Exécuter Maven build
  # Le résultat est un fichier JAR construit
RUN mvn -B package --file pom.xml
  
  # Étape de l'image finale
FROM eclipse-temurin:17-jre
  
  # Copier le fichier JAR de l'étape de build à l'image finale
COPY --from=build /app/target/testDocker-1.0-SNAPSHOT.jar /testDocker-1.0-SNAPSHOT.jar
  
  # Commande pour exécuter l'application
CMD ["java", "-jar", "/testDocker-1.0-SNAPSHOT.jar"]
