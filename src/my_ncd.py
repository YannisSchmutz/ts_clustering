import gzip

def __compressed_length(obj : bytes):
    return len(gzip.compress(obj))

def ncd_string(o1 : str, o2 : str) -> float:
    x = o1.encode('ascii')
    y = o2.encode('ascii')

    cx = __compressed_length(x)
    cy = __compressed_length(y)

    cxy = __compressed_length(x + y)
    
    d = (cxy - min(cx, cy))/max(cx, cy)
    return d


if __name__ == '__main__':
    dist0 = ncd_string('aaa', 'aaa')
    print(dist0)

    dist1 = ncd_string('aaa', 'aab')
    print(dist1)

    dist2 = ncd_string('abc', 'xyz')
    print(dist2)

    dist3 = ncd_string('Hello World!', 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.')
    print(dist3)
