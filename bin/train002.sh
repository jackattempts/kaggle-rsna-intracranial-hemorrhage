model=model002
gpu=0
fold=0
conf=./conf/${model}.py

for i in 0 1 2 3 4
do
    python -m src.cnn.main train ${conf} --fold ${i} --gpu ${gpu}
done
