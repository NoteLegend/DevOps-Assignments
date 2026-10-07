FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app
COPY Hello.java .
RUN javac Hello.java
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/Hello.class .
USER 10001
EXPOSE 8080
CMD ["java", "Hello"]
