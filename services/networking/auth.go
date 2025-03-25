package networking

import (
	"crypto/rsa"
	"github.com/golang-jwt/jwt/v5"
)

var (
	verifyKey *rsa.PublicKey
	signKey   *rsa.PrivateKey
)

func InitAuth(publicKeyPath, privateKeyPath string) error {
	// Load RSA keys for JWT
	signBytes, _ := os.ReadFile(privateKeyPath)
	signKey, _ = jwt.ParseRSAPrivateKeyFromPEM(signBytes)
	
	verifyBytes, _ := os.ReadFile(publicKeyPath)
	verifyKey, _ = jwt.ParseRSAPublicKeyFromPEM(verifyBytes)
	
	return nil
}

func ValidateToken(tokenString string) bool {
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		return verifyKey, nil
	})
	return err == nil && token.Valid
}