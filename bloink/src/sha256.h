// still public domain
#ifndef BLOINK_SHA256_H
#define BLOINK_SHA256_H
#include <stddef.h>
#include <stdint.h>

typedef struct {
  uint8_t data[64];
  uint32_t datalen;
  uint64_t bitlen;
  uint32_t state[8];
} SHA256_CTX;

void sha256_init(SHA256_CTX *ctx);
void sha256_update(SHA256_CTX *ctx, const uint8_t data[], size_t len);
void sha256_final(SHA256_CTX *ctx, uint8_t hash[32]);

/* convenience: hash a buffer and hex-encode into out (needs 65 bytes) */
void sha256_hex(const uint8_t *data, size_t len, char out[65]);

/* convenience: hash multiple strings in sequence (used to combine a
 * recipe's own content-hash with its resolved dependency hashes) */
void sha256_hex_multi(const char **parts, int n_parts, char out[65]);

#endif
