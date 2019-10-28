model=model002
gpu=0
fold=0
ep=1
tta=5
clip=1e-6
conf=./conf/${model}.py


for i in 0 1 2 3 4
do
  snapshot=./model/${model}/fold${i}_ep${ep}.pt
  valid=./model/${model}/fold${i}_ep${ep}_valid_tta${tta}.pkl
  test=./model/${model}/fold${i}_ep${ep}_test_tta${tta}.pkl
  sub=./data/submission/${model}_fold${i}_ep${ep}_test_tta${tta}.csv

  python -m src.cnn.main test ${conf} --snapshot ${snapshot} --output ${test} --n-tta ${tta} --fold ${i} --gpu ${gpu}
  python -m src.postprocess.make_submission --input ${test} --output ${sub} --clip ${clip}
  #kaggle competitions submit rsna-intracranial-hemorrhage-detection -m "" -f ./data/submission/${sub}
done
