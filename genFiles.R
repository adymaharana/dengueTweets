temp = mgmap@data
len = nrow(temp)
for (i in 1:len)
{
  if (temp[i,6] == 0)
  {
    code = as.numeric(as.character(temp$CD_GEOCMU[i]))
    code = as.integer(code/10)
    temp[i,6] = code
  }
}
write.csv(temp[,3:6], "MinaisGeras_2013_14.csv")
temp = rjmap@data
len = nrow(temp)
for (i in 1:len)
{
  if (temp[i,6] == 0)
  {
    code = as.numeric(as.character(temp$CD_GEOCMU[i]))
    code = as.integer(code/10)
    temp[i,6] = code
  }
}
write.csv(temp[,3:6], "RioJaneiro_2013_14.csv")
temp = spmap@data
len = nrow(temp)
for (i in 1:len)
{
  if (temp[i,6] == 0)
  {
    code = as.numeric(as.character(temp$CD_GEOCMU[i]))
    code = as.integer(code/10)
    temp[i,6] = code
  }
}
write.csv(temp[,3:6], "SaoPaulo_2013_14.csv")
