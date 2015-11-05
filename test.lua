local neon = require 'neon'

print("Neon loaded succesfully!")

a = torch.CudaTensor(3, 2):normal()
b = torch.CudaTensor(2, 4):normal()

c = neon.mm(a, b)
d = torch.mm(a, b)

print(a)
print(b)


print(c)
print(d)
