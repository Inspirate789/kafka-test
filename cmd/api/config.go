package main

import (
	"github.com/segmentio/kafka-go/compress"
	"time"

	"github.com/segmentio/kafka-go"
)

//var writer *kafka.Writer

func Configure(kafkaBrokerUrls []string, clientId string, topic string) (*kafka.Writer, error) {
	//writer = w
	return &kafka.Writer{
		Addr:         kafka.TCP(kafkaBrokerUrls...),
		Topic:        topic,
		Balancer:     &kafka.LeastBytes{},
		Transport:    &kafka.Transport{ClientID: clientId},
		WriteTimeout: 10 * time.Second,
		ReadTimeout:  10 * time.Second,
		Compression:  compress.Snappy,
	}, nil
}
