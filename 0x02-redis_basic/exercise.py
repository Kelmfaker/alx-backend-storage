#!/usr/bin/env python3

import redis
import uuid
from typing import Union, Callable, Optional


def call_history(method: Callable) -> Callable:
    def wrapper(*args, **kwargs):
        r = redis.Redis()
        input_key = f"{method.__qualname__}:inputs"
        output_key = f"{method.__qualname__}:outputs"

        # Store the input arguments
        r.rpush(input_key, str(args))

        # Execute the original function
        result = method(*args, **kwargs)

        # Store the output
        r.rpush(output_key, str(result))

        return result
    return wrapper


class Cache:
    def __init__(self):
        self._redis = redis.Redis()
        self._redis.flushdb()

    @call_history
    def store(self, data: Union[str, bytes, int, float]) -> str:
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key: str, fn: Optional[Callable] = None) -> None:
        value = self._redis.get(key)
        if value is None:
            return None
        if fn:
            return fn(value)
        return value

    def get_str(self, key: str) -> Optional[str]:
        return self.get(key, lambda x: x.decode('utf-8'))

    def get_int(self, key: str) -> Optional[int]:
        return self.get(key, int)
