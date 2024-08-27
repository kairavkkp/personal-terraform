package main

import (
	"log"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(handler)
}

func handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	log.Println("Hello World!")
	response := events.APIGatewayProxyResponse{
		StatusCode: 200,
	}
	return response, nil
}

// Refer this: https://docs.aws.amazon.com/lambda/latest/dg/golang-package.html#golang-package-mac-linux