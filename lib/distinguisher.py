# coding: UTF-8

import FSM
from util import *


def readData(filename):
    print filename
    h = open(filename, 'r')
    words = []
    british = []
    american = []

    for l in h.readlines():
        a = l.split(':')
        if len(a) == 1:
            words.append(a[0].strip())
            british.append(None)
            american.append(None)
        elif len(a) == 2:
            words.append(a[0].strip())
            british.append(a[1].strip())
            american.append(None)
        elif len(a) == 3:
            words.append(a[0].strip())
            british.append(a[1].strip())
            american.append(a[2].strip())

    return (words, british, american)


def testFileLines(filename="data/test/usa_uk.txt"):
    h = open(filename, 'r')
    for l in h.readlines():
        a = l.split('^')
        yield(a[0], a[1], a[2], a[3], a[4])


def evaluate(truth, hypothesis):
    I = 0
    T = 0
    H = 0
    for n in range(len(truth)):
        t = truth[n].split('+')
        allT = {}
        cumSum = 0
        for ti in t:
            cumSum = cumSum + len(ti)
            allT[cumSum] = 1

        h = hypothesis[n].split('+')
        allH = {}
        cumSum = 0
        for hi in h:
            cumSum = cumSum + len(hi)
            allH[cumSum] = 1

        T = T + len(allT) - 1
        H = H + len(allH) - 1
        for i in allT.iterkeys():
            if i in allH:
                I = I + 1
        I = I - 1

    Pre = 1.0
    Rec = 0.0
    Fsc = 0.0
    if I > 0:
        Pre = float(I) / H
        Rec = float(I) / T
        Fsc = 2 * Pre * Rec / (Pre + Rec)
    return (Pre, Rec, Fsc)


def bigramSourceModel(segmentations):
    # compute all bigrams
    lm = {}
    vocab = {}
    vocab['end'] = 1
    for s in segmentations:
        prev = 'start'
        for c in s:
            if prev not in lm:
                lm[prev] = Counter()
            lm[prev][c] = lm[prev][c] + 1
            prev = c
            vocab[c] = 1
        if prev not in lm:
            lm[prev] = Counter()
        lm[prev]['end'] = lm[prev]['end'] + 1

    # smooth and normalize
    for prev in lm.iterkeys():
        for c in vocab.iterkeys():
            lm[prev][c] = lm[prev][c] + 0.5   # add 0.5 smoothing
        lm[prev].normalize()

    print "Language Model keys"
    print lm['b'].keys()

    # convert to a FSA
    fsa = FSM.FSM(isProbabilistic=True)
    fsa.setInitialState('start')
    fsa.setFinalState('end')

    # Character states in bigram model
    for char in lm['start']:
        fsa.addEdge('start', char, char, lm['start'][char])

    # Transitions between character states or to 'end'
    for char in lm.keys():
        if not char == 'start':
            for second_char in lm[char]:
                if second_char == 'end':
                    fsa.addEdge(char, second_char, None, prob=lm[char][second_char])
                else:
                    fsa.addEdge(char, second_char, second_char, prob=lm[char][second_char])

    return fsa


def compare_results(usa_file="tmp.usa.output", uk_file="tmp.uk.output"):
    us = open(usa_file, 'r')
    uk = open(uk_file, 'r')

    score = 0

    for us_line in us.readlines():
        us_score = float(us_line.split()[-1])
        uk_score = float(uk.readline().strip().split()[-1])

        if us_score > uk_score:
            score += 1
        else:
            score -= 1

    return score


def runTest(trainFile='bengali.train', devFile='OEDResultsUniqClean.txt', source=bigramSourceModel):
    # def runTest(trainFile='bengali.train', devFile='OEDResultsUniq.txt', channel=stupidChannelModel, source=stupidSourceModel):
    path_to_data = "data/speech_accent_archive/"
    (words, british, american) = readData(path_to_data + devFile)

    # (wordsDev, segsDev) = readData(devFile)
    # fst = channel(words, segs)
    uk_fsa = source(british)
    usa_fsa = source(american)

    # uk_output = FSM.runFST([uk_fsa], british, quiet=False)
    # usa_output = FSM.runFST([usa_fsa], american, quiet=False)

    # print "==== Trying American source model on strings ===="
    # output = FSM.runFST([usa_fsa], ["treɪn", "steɪʃən", "meɪbi", "bbbbbbb"], outfile="tmp.test.output")
    # print "==== Result: ", str(output), " ===="

    correct = 0
    total = 0

    for country, src, loc, gender, trans in testFileLines():
        total += 1
        words = trans.split(',')
        FSM.runFST([usa_fsa], words, outfile="tmp.usa.output")
        FSM.runFST([uk_fsa], words, outfile="tmp.uk.output")

        result = compare_results("tmp.usa.output", "tmp.uk.output")

        if result > 0 and country == "usa":
            correct += 1
        elif result < 0 and country == "uk":
            correct += 1
        else:
            print "Got one wrong.  Misabeled " + src

    print "Summary:\n"
    print "Got " + str(correct) + " correct for an accuracy of " + str(100.0 * correct / total) + "%"

    # print "==== Trying British source model on string 'meet' -> 'mi\xcb\x90t' ===="
    # output = FSM.runFST([uk_fsa], ["mi\xcb\x90t"])
    # print "==== Result: ", str(output), " ===="

    # print "==== Trying British source model on string 'will' -> 'w\xc9\xaal' ===="
    # output = FSM.runFST([uk_fsa], ["w\xc9\xaal"])
    # print "==== Result: ", str(output), " ===="

    # print "==== Trying British source model on string 'brother' -> 'brʌðə' ===="
    # output = FSM.runFST([uk_fsa], ["brʌðə"])
    # print "==== Result: ", str(output), " ===="

    # print "==== Trying British source model on FAKE string 'bbbbbbb' -> 'bbbbbbb' ===="
    # output = FSM.runFST([uk_fsa], ["bbbbbbb"])
    # print "==== Result: ", str(output), " ===="

    # print "\n================================\n"

    # preTrainOutput = FSM.runFST([uk_fsa], british, quiet=True)
    # for i in range(len(preTrainOutput)):
    #     if len(preTrainOutput[i]) == 0:
    #         preTrainOutput[i] = words[i]
    #     else:
    #         preTrainOutput[i] = preTrainOutput[i][0]
    # preTrainEval = evaluate(british, preTrainOutput)
    # print 'before training, P/R/F = ', str(preTrainEval)

    # preTrainOutput = runFST([fsa, fst], wordsDev, quiet=True)
    # for i in range(len(preTrainOutput)):
    #     if len(preTrainOutput[i]) == 0:
    #         preTrainOutput[i] = words[i]
    #     else:
    #         preTrainOutput[i] = preTrainOutput[i][0]
    # preTrainEval = evaluate(segsDev, preTrainOutput)
    # print 'before training, P/R/F = ', str(preTrainEval)

    # fst.trainFST(words, segs)

    # postTrainOutput = runFST([fsa, fst], wordsDev, quiet=True)
    # for i in range(len(postTrainOutput)):
    #     if len(postTrainOutput[i]) == 0:
    #         postTrainOutput[i] = words[i]
    #     else:
    #         postTrainOutput[i] = postTrainOutput[i][0]
    # postTrainEval = evaluate(segsDev, postTrainOutput)
    # print 'after  training, P/R/F = ', str(postTrainEval)

    # return postTrainOutput
    return


def saveOutput(filename, output):
    h = open(filename, 'w')
    for o in output:
        h.write(o)
        h.write('\n')
    h.close()

if __name__ == '__main__':
    output = runTest()
    # print output
