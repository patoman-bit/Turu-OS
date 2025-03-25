package ai_engine

import (
	"bytes"
	"encoding/json"
	"net/http"
)

type AIRequest struct {
	Prompt     string `json:"prompt"`
	MaxTokens  int    `json:"max_tokens"`
	Temperature float64 `json:"temperature"`
}

func ProcessLocal(prompt string) (string, error) {
	req := AIRequest{
		Prompt:     prompt,
		MaxTokens:  150,
		Temperature: 0.7,
	}
	
	body, _ := json.Marshal(req)
	resp, err := http.Post(
		"http://localhost:8000/generate",
		"application/json",
		bytes.NewBuffer(body),
	)
	
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()
	
	var result map[string]interface{}
	json.NewDecoder(resp.Body).Decode(&result)
	return result["text"].(string), nil
}