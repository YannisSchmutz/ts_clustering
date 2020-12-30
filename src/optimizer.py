import numpy as np


def get_cvi_combination(sil, dunn, db, ch):
    sil_values = np.array(sil)
    dunn_values = np.array(dunn)
    db_values = np.array(db)
    ch_values = np.array(ch)
    
    db_inv_values = np.array(list(map(lambda v: 1/v, db)))

    sil_mean = sil_values.mean()
    sil_std = sil_values.std()

    dunn_mean = dunn_values.mean()
    dunn_std = dunn_values.std()

    db_mean = db_values.mean()
    db_std = db_values.std()

    ch_mean = ch_values.mean()
    ch_std = ch_values.std()


    db_inv_mean = db_inv_values.mean()
    db_inv_std = db_inv_values.std()

    sil_n_values = (sil_values - sil_mean) / sil_std
    dunn_n_values = (dunn_values - dunn_mean) / dunn_std
    db_n_values = (db_values - db_mean) / db_std
    ch_n_values = (ch_values - ch_mean) / ch_std

    db_inv_n_values = (db_inv_values - db_inv_mean) / db_inv_std
    
    combination = sil_n_values + dunn_n_values + db_inv_n_values + ch_n_values
    return combination
